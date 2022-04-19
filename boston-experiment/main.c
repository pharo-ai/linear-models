/* Based on: https://www.intel.com/content/www/us/en/develop/documentation/onemkl-lapack-examples/top/least-squares-and-eigenvalue-problems/linear-least-squares-lls-problems/gelsd-function/dgelsd-example/lapacke-dgelsd-example-c-row.html */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


/* Constants */
#define LINE_BUFFER_SIZE 4098

/* Relative paths to the CSV files containing matrices A and B */
#define A_FILENAME "data/boston-train.csv"
#define B_FILENAME "data/boston-train-labels.csv"

#define MAX(x, y) (((x) > (y)) ? (x) : (y))
#define MIN(x, y) (((x) < (y)) ? (x) : (y))


/* DGELSD prototype */
extern void dgelsd(int* m, int* n, int* nrhs, double* a, int* lda,
                double* b, int* ldb, double* s, double* rcond, int* rank,
                double* work, int* lwork, int* iwork, int* info);

/* Auxiliary routines prototypes */
extern void print_matrix(char* desc, int m, int n, double* a, int lda);
extern int count_rows(char* filename);
extern int count_columns(char* filename);
extern void read_csv(int rows, int columns, char* filename, double* array);


int main() {
    /* Locals */
    int info, lwork, rank;

    /* Negative rcond means using default (machine precision) value */
    double rcond = -1.0;
    double wkopt;
    double* work;

    /* Count the number of rows and columns of matrix A */
    int rows = count_rows(A_FILENAME);
    int columns = count_columns(A_FILENAME);

    /* Count the number of right hand sides (NRHS) - number of columns of matrix B */
    int nrhs = count_columns(B_FILENAME);

    /* Allocate memory for both matrices */
    double* a = (double*) malloc(rows * columns * sizeof(double));
    double* b = (double*) malloc(rows * nrhs * sizeof(double));

    /* Read the data */
    read_csv(rows, columns, A_FILENAME, a);
    read_csv(rows, nrhs, B_FILENAME, b);

    /* LDA - Leading dimension of matrix A
       LDB - leading dimension of matrix B */
    int lda = MAX(1, rows);
    int ldb = MAX(1, MAX(rows, columns));

    int* iwork = (int*) malloc(3 * rows * 0 + 11 * rows * sizeof(int));
    double* s = (double*) malloc(rows * sizeof(double));

    /* Executable statements */
    printf(" DGELSD Example Program Results\n");

    /* Query and allocate the optimal workspace */
    lwork = -1;
    dgelsd(&rows, &columns, &nrhs, a, &lda, b, &ldb, s, &rcond, &rank, &wkopt, &lwork,
                    iwork, &info);
    lwork = (int) wkopt;
    work = (double*) malloc(lwork*sizeof(double));

    /* Solve the equations A*X = B */
    dgelsd(&rows, &columns, &nrhs, a, &lda, b, &ldb, s, &rcond, &rank, work, &lwork,
                    iwork, &info);
    
    /* Check for convergence */
    if (info > 0) {
        printf("The algorithm computing SVD failed to converge;\n");
        printf("the least squares solution could not be computed.\n");
        exit(1);
    }

    /* Print minimum norm solution */
    print_matrix("Minimum norm solution", columns, nrhs, b, ldb);

    /* Print effective rank */
    printf("\n Effective rank = %i\n", rank);

    /* Print singular values */
    print_matrix("Singular values", 1, rows, s, 1);

    /* Free workspace */
    free(work);
    free(s);
    free(iwork);
    free(b);
    free(a);

    exit(0);
}

/* Count the number of rows (lines) in a file.
The line ending must be \n (LF) and not \r (CR)
*/
int count_rows(char* filename) {
    FILE* file = fopen(filename, "r");
    int count = 0;
    char ch;

    while((ch = fgetc(file)) != EOF) {
      if(ch == '\n')
         count++;
    }
    fclose(file);
    return count + 1;
}

/* Count the number of columns in a CSV file.
Entries must be separated by a comma ','.
Only looks at the first line
*/
int count_columns(char* filename) {
    FILE* file = fopen(filename, "r");

    char line[LINE_BUFFER_SIZE];
    fgets(line, LINE_BUFFER_SIZE, file);

    fclose(file);

    int count = 0;

    for (int i = 0; line[i]; ++i) {
        if (line[i] == ',') ++count;
    }

    return count + 1;
}

/* Read a CSV file into a 1-D array

Arguments:
    rows: number of rows
    columns: number of columns
    filename: relative path to file
    array: pointer to an array where the data will be written
*/
void read_csv(int rows, int columns, char* filename, double* array){
    FILE* file = fopen(filename, "r");
    int i = 0;

    char line[LINE_BUFFER_SIZE];
    while (fgets(line, LINE_BUFFER_SIZE, file) && (i < rows)) {
        char* tmp = strdup(line);

        int j = 0;
        const char* tok;
        for (tok = strtok(line, ","); tok && *tok; j++, tok = strtok(NULL, ",\n")) {
            array[i * columns + j] = atof(tok);
        }

        free(tmp);
        i++;
    }
}

/* Print a matrix.

Arguments:
    description: a string to be displayed
    rows: number of rows
    columns: number of columns
    array: matrix as a 1-D array of size (rows * columns)
    lda: leading dimension of a matrix
*/
void print_matrix(char* description, int rows, int columns, double* array, int lda) {
    printf("\n %s\n", description);

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            printf("%6.6f", array[i + j * lda]);
        }
        printf("\n");
    }
}