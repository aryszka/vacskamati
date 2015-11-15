(function () {
    "use strict";

    const log = console.log.bind(console);

    const waitOrInit = () => {
        const vm = window.vacskamati;
        if (!vm) {
            setTimeout(waitOrInit, 0);
            return;
        }

        const ti = vm.ports.testIn;
        const to = vm.ports.testOut;

        var initial = 0;
        const send = () => ti.send(initial++);
        setInterval(send, 999)

        to.subscribe(log);
    };

    window.addEventListener("load", waitOrInit);
})();
