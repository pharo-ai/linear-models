/* Based on: https://textbooks.math.gatech.edu/ila/least-squares.html

This code simply loads the data from CSV files, makes a call
to Lapack DGELSD routine, and prints the result.

To build the code:
gcc -Wall -o executable small-one-lapack-example.c -llapack

There is no data preprocessing - matrices A and B are not modified.
*/

/*
Matrix A: 
   0.0   1.1
   1.0   0.0
   0.0  -0.2

Matrix B:
   1.1
  -1.1
  -0.2

Minimum norm solution
  -1.1
   1.0
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Constants */
#define LINE_BUFFER_SIZE 4098

#define MAX(x, y) (((x) > (y)) ? (x) : (y))
#define MIN(x, y) (((x) < (y)) ? (x) : (y))

/* DGELSD prototype */
extern void dgelsd(int *m, int *n, int *nrhs, double *a, int *lda,
                   double *b, int *ldb, double *s, double *rcond, int *rank,
                   double *work, int *lwork, int *iwork, int *info);

/* Auxiliary routines prototypes */
extern void print_matrix(char *desc, int m, int n, double *a, int lda);
void print_list(char *description, double *array, int rows, int columns);

int main()
{
        /* Locals */
        int info, lwork, rank;

        /* Negative rcond means using default (machine precision) value */
        double rcond = -1.0;
        double wkopt;
        double *work;

        /* Count the number of rows and columns of matrix A */
        int rows = 3;
        int columns = 2;

        /* Count the number of right hand sides (NRHS) - number of columns of matrix B */
        int nrhs = 1;

        // Initialize the matrices in a column major form.
        double a[3 * 2] = {
           0.0,   1.0,   0.0,
           1.1,   0.0,  -0.2 };
        double b[3 * 1] = {
            1.1,
           -1.1
           -0.2 };

        /* LDA - Leading dimension of matrix A
           LDB - leading dimension of matrix B */
        int lda = MAX(1, rows);
        int ldb = MAX(1, MAX(rows, columns));

        int *iwork = (int *)malloc(3 * rows * 0 + 11 * rows * sizeof(int));
        double *s = (double *)malloc(rows * sizeof(double));

        /* Executable statements */
        printf(" DGELSD Example Program Results\n");

        /* Query and allocate the optimal workspace */
        lwork = -1;
        dgelsd(&rows, &columns, &nrhs, a, &lda, b, &ldb, s, &rcond, &rank, &wkopt, &lwork,
               iwork, &info);
        lwork = (int)wkopt;
        work = (double *)malloc(lwork * sizeof(double));

        /* Solve the equations A*X = B */
        dgelsd(&rows, &columns, &nrhs, a, &lda, b, &ldb, s, &rcond, &rank, work, &lwork,
               iwork, &info);

        /* Check for convergence */
        if (info > 0)
        {
                printf("The algorithm computing SVD failed to converge;\n");
                printf("the least squares solution could not be computed.\n");
                exit(1);
        }

        /* Print minimum norm solution */
        print_list("Minimum norm solution array", b, columns, nrhs);
        print_matrix("Minimum norm solution", columns, nrhs, b, ldb);

        /* Print effective rank */
        printf("\n Effective rank = %i\n", rank);

        /* Print singular values */
        print_matrix("Singular values", 1, rows, s, 1);

        /* Free workspace */
        free(work);
        free(s);
        free(iwork);

        exit(0);
}

/* Print a matrix.

Arguments:
    description: a string to be displayed
    rows: number of rows
    columns: number of columns
    array: matrix as a 1-D array of size (rows * columns)
    lda: leading dimension of a matrix
*/
void print_matrix(char *description, int rows, int columns, double *array, int lda)
{
        printf(" \n %s \n ", description);

        for (int i = 0; i < rows; i++)
        {
                for (int j = 0; j < columns; j++)
                {
                        printf(" %6.6f ", array[i + j * lda]);
                }
                printf(" \n ");
        }
}

void print_list(char *description, double *array, int rows, int columns)
{
        printf(" \n %s \n ", description);

        for(int i=0; i<(rows * columns); i++) {
                printf("%6.6f ", array[i]);
        }
        printf(" \n ");
}