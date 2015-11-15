#! /usr/bin/awk -f

{placeholder="^\\s*{# .* #}\\s*$"}

$0 ~ placeholder {
    name=gensub(/([.]js)|([.]elm)$/, ".min.js", 1, $2)
    system("cat obj/" name)
}

$0 !~ placeholder { print }
