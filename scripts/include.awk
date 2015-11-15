#! /usr/bin/awk -f

{
    placeholder="^\\s*{# .* #}\\s*$";
    min=""
}

$0 ~ placeholder {
    min = ""
    if (minimized=="true") {
        min = ".min"
    }
    
    name=gensub(/([.]js)|([.]elm)$/, "$min.js", 1, $2)
    system("cat obj/" name)
}

$0 !~ placeholder { print }
