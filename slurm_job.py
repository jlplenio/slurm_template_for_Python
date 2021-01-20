#!/usr/bin/env python
from multiprocessing import Pool
import csv
import timeit
import sys


def calc_pi(run_no):
    from decimal import Decimal, getcontext
    getcontext().prec = 100000
    result = sum(1 / Decimal(16) ** k *
                 (Decimal(4) / (8 * k + 1) -
                  Decimal(2) / (8 * k + 4) -
                  Decimal(1) / (8 * k + 5) -
                  Decimal(1) / (8 * k + 6)) for k in range(100))
    print("done", run_no)
    return result


if __name__ == '__main__':
    core_count = 1
    if len(sys.argv) > 1:
        core_count = int(sys.argv[1])

    print(f"Starting with {core_count} counts")
    start = timeit.default_timer()

    with Pool(core_count) as p:
        pi_list = (p.map(calc_pi, range(100)))

    with open("out/pi_list.csv", 'w', newline='') as file:
        wr = csv.writer(file, quoting=csv.QUOTE_ALL)
        wr.writerow(pi_list)

    stop = timeit.default_timer()

    print('Time: ', stop - start)
