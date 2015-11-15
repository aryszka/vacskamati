#! /usr/bin/awk -f

BEGIN {
    placeholder="^.*{#\\s*\\S*\\s*#}.*$";
    min = ""
    if (minimized=="true") {
        min = ".min"
    }
}

$0 ~ placeholder {
    open = gensub(/{#.*$/, "", 1, $0)
    name = gensub(/^.*{#\\s*/, "", 1, $0)
    name = gensub(/\\s*#}.*$/, "", 1, $0)
    name = gensub(/([.]js)|([.]elm)$/, min ".js", 1, $2)
    closer = gensub(/^.*#}/, "", 1, $0)
    print open
    system("cat obj/" name)
    print closer
}

$0 !~ placeholder { print }
