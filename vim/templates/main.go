package main

import (
	"flag"
	"fmt"
	"os"
)

var (
	dbg = flag.Bool("dbg", false, "print debug spew")
	out = flag.String("out", "output.ext", "output help message")
)

func main() {
	flag.Parse()
	if flag.NArg() == 0 || *out == "" {
		fmt.Fprintf(os.Stderr, "usage: %s [OPTIONS] <INPUT>...\n", os.Args[0])
		flag.PrintDefaults()
		os.Exit(2)
	}

	for _, arg := range flag.Args() {
		debug("%s", arg)
	}
}


func debug(format string, head interface{}, tail ...interface{}) {
	if !*dbg {
		return
	}
	format = os.Args[0] + ": " + format + "\n"
	args := make([]interface{}, 1, len(tail) + 1)
	args[0] = head
	args = append(args, tail...)
	fmt.Fprintf(os.Stderr, format, args...)
}
