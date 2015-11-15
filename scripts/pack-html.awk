#! /usr/bin/awk -f

BEGIN {
    placeholder = "^.*{#\\s*\\S\\S*\\s*#}.*$"
    beforeopen  = "^.*{#\\s*"
    afteropen   = "{#.*$"
    beforeclose = "^.*#}"
    afterclose  = "\\s*#}.*$"
    ext         = "([.]js)|([.]elm)$"

    min = ""
    if (minimized == "true") {
        min = ".min"
    }
}

$0 ~ placeholder {
    opentag  = gensub(afteropen, "", 1, $0)
    closetag = gensub(beforeclose, "", 1, $0)

    name = gensub(beforeopen, "", 1, $0)
    name = gensub(afterclose, "", 1, name)
    name = gensub(ext, min ".js", 1, name)

    print opentag
    rt = system("cat obj/" name)
    if (rt != 0) {
        exit rt
    }

    print closetag
}

$0 !~ placeholder { print }
