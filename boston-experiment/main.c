#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* DGELSD prototype */
extern void dgelsd(int* m, int* n, int* nrhs, double* a, int* lda,
                double* b, int* ldb, double* s, double* rcond, int* rank,
                double* work, int* lwork, int* iwork, int* info);

/* Auxiliary routines prototypes */
extern void print_matrix(char* desc, int m, int n, double* a, int lda);
extern int count_rows(char* filename);
extern int count_columns(char* filename);
extern void read_csv(int rows, int columns, char* filename, double* array);

/* Constants */
#define LINE_BUFFER_SIZE 4098

#define MAX(x, y) (((x) > (y)) ? (x) : (y))
#define MIN(x, y) (((x) < (y)) ? (x) : (y))

/* Parameters */
#define NRHS 1
#define X_FILENAME "data/boston-train.csv"
#define Y_FILENAME "data/boston-train-labels.csv"

int main() {
    /* Locals */
    int nrhs = NRHS, info, lwork, rank;

    /* Negative rcond means using default (machine precision) value */
    double rcond = -1.0;
    double wkopt;
    double* work;

    char* filename = X_FILENAME;
    int rows = count_rows(filename);
    int columns = count_columns(filename);

    double* a = (double*) malloc(rows * columns * sizeof(double));
    double* b = (double*) malloc(rows * sizeof(double));

    read_csv(rows, columns, filename, a);
    read_csv(rows, 1, Y_FILENAME, b);

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
    free((void*) work);
    free(s);
    free(iwork);
    free(b);
    free(a);

    exit(0);
}

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

void read_csv(int rows, int columns, char* filename, double* array){
    FILE* file = fopen(filename, "r");
    int i = 0;

    char line[LINE_BUFFER_SIZE];
    while (fgets(line, LINE_BUFFER_SIZE, file) && (i < rows))
    {
        char* tmp = strdup(line);

        int j = 0;
        const char* tok;
        for (tok = strtok(line, ","); tok && *tok; j++, tok = strtok(NULL, ",\n"))
        {
            array[i * columns + j] = atof(tok);
        }

        free(tmp);
        i++;
    }
}

/* Auxiliary routine: printing a matrix */
void print_matrix(char* desc, int m, int n, double* a, int lda) {
    int i, j;
    printf("\n %s\n", desc);
    for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) printf("%6.6f", a[i+j*lda]);
        printf("\n");
    }
}