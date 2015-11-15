#! /usr/bin/awk -f

BEGIN {
    placeholder = "^--\\s*\\[placeholder\\]\\s*"
}

$0 ~ placeholder {
    name = gensub(placeholder, "", 1, $0)
    system("cat obj/" name)
}

$0 !~ placeholder { print }
