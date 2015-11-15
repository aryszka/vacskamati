(function () {
    "use strict";

    window.addEventListener("load", function () {
        var root = document.getElementsByClassName("app-root")[0];
        window.vacskamati = Elm.embed(Elm.Main, root, {testIn: 0});
    });
})();
