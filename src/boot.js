(function () {
    "use strict";

    window.addEventListener("load", function () {
        var root = document.getElementsByClassName("app-root")[0];
        Elm.embed(Elm.App, root);
    });
})();
