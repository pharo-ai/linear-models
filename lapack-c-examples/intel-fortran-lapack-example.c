/* Based on: https://www.intel.com/content/www/us/en/develop/documentation/onemkl-lapack-examples/top/least-squares-and-eigenvalue-problems/linear-least-squares-lls-problems/gelsd-function/dgelsd-example/lapacke-dgelsd-example-c-row.html

This code simply loads the data from CSV files, makes a call
to Lapack DGELSD routine, and prints the result.

To build the code:
gcc -Wall -o executable intel-fortran-lapack-example.c -llapack

There is no data preprocessing - matrices A and B are not modified.
*/

/*
Matrix A: 
   0.12  -8.19   7.69  -2.26  -4.71
  -6.91   2.22  -5.12  -9.08   9.96
  -3.33  -8.94  -6.72  -4.40  -9.98
   3.97   3.33  -2.74  -7.92  -3.20

Matrix B:
   7.30   0.47  -6.28
   1.33   6.58  -3.42
   2.68  -1.71   3.46
  -9.62  -0.79   0.41

Minimum norm solution
  -0.69  -0.24   0.06
  -0.80  -0.08   0.21
   0.38   0.12  -0.65
   0.29  -0.24   0.42
   0.29   0.35  -0.30

Effective rank =  4

Singular values
18.66  15.99  10.01   8.51
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
        int rows = 4;
        int columns = 5;

        /* Count the number of right hand sides (NRHS) - number of columns of matrix B */
        int nrhs = 3;

        // Initialize the matrices in a column major form.
        double a[5 * 4 ] = {
            0.12, -6.91, -3.33,  3.97,
           -8.19,  2.22, -8.94,  3.33,
            7.69, -5.12, -6.72, -2.74,
           -2.26, -9.08, -4.4,  -7.92,
           -4.71,  9.96, -9.98, -3.2 };
        double b[3 * 5] = {
            7.3,   1.33,  2.68, -9.62,
            0.47,  6.58, -1.71, -0.79,
           -6.28, -3.42,  3.46,  0.41 };

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