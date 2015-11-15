(() => {
    "use strict";

    const Fs = require("fs");
    const stdin = process.stdin;
    const stdout = process.stdout;
    const worker = Elm.worker(Elm.Test, {responses: null});
    const requests = worker.ports.requests;
    const responses = worker.ports.responses;
    const just = v => {Just: v}
    const send = m => responses.send(m === null ? null : just(m));

    const isLastNotGet = all =>
        all.length !== 0 && all[all.length - 1].ctor !== "Get";

    const handleRequest = request => {
        switch (request.ctor) {
        case "Put":
            stdout.write(request.val);
            break;
        case "Get":
            stdin.resume();
            break;
        case "Exit":
            process.exit(request.val);
            break;
        case "WriteFile":
            Fs.writeFileSync(request.file, request.content);
            break;
        }
    };

    const handleAllRequests = all => {
        all.map(handleRequest);
        if (isLastNotGet(all)) {
            send("");
        }
    };

    const handleInput = data => {
        stdin.pause();
        send(data.toString());
    };

    stdin.on("data", handleInput);
    requests.subscribe(handleAllRequests);
    send(null);
})();
