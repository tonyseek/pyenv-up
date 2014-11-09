#!/usr/bin/env python

import os
import sys
from signal import SIGTERM
from subprocess import Popen, PIPE


def takesince(predicate, iterable):
    iterator = iter(iterable)
    for x in iterator:
        if predicate(x):
            return list(iterator)


def capture_and_kill(line_num, args):
    proc = Popen(args, preexec_fn=os.setsid, stdout=PIPE, stdin=PIPE)
    try:
        for line in xrange(line_num):
            print proc.stdout.readline(),
    finally:
        proc.terminate()
        try:
            os.killpg(proc.pid, SIGTERM)
        except OSError:
            pass
        proc.wait()

if __name__ == '__main__':
    args = takesince(lambda x: x == '--', sys.argv)
    if not args:
        print >> sys.stderr, "Usage: %s [LINE_NUM] -- [ARGS]" % sys.argv[0]
        sys.exit(1)

    try:
        line_num = int(sys.argv[1])
    except (IndexError, ValueError):
        line_num = 1

    capture_and_kill(line_num, args)
