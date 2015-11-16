#! /usr/bin/awk -f

BEGIN { first = 0 }

{
    name = gensub(".*/", "", 1, $0)
    name = gensub("[.].*", "", 1, name)

    if (type == "imports") {
        print "import " name
    } else {
        if (first != 0) {
            print "  ,"
        }

        print "  " name ".tests"
    }

    first = 1
}
