$(document).ready(function(){
    if (!!window.EventSource) { // open server using browser
        console.log('SSE supported.');
        var source = new EventSource('http://localhost:5000/bpm'); // EventSource opens persistent connection to HTTP server and send events in text/event-stream format

        // reference: https://developer.mozilla.org/en-US/docs/Web/API/EventSource

        source.addEventListener('message', function(e) { // event is called when new message arrive
        console.log(e.data);
        }, false);

        source.addEventListener('open', function(e) { // open connection
        console.log('Connection was opened.');
        }, false);

        source.addEventListener('error', function(e) { // close connection
        if (e.readyState == EventSource.CLOSED) {
            console.log('Connection was closed.');
        }
        }, false);

    } else {
        console.log('SSE not supported.'); // browser not supported
    }
});