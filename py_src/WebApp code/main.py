from flask import Flask, render_template, Response, send_from_directory, jsonify
import serial 
import threading

# py -m flask run
# http://localhost:5000/

app = Flask(__name__)

data = ""

def serialStream():
    global data
    serialIn = serial.Serial(port='COM7', baudrate=9600) # port is com port that arduino is connected to
    buffer = ''
    while (1):
        buffer += serialIn.readline().decode('utf-8') # convert ASCII into string
        # use readline since println from arudino => will read until end of line
        bpm = buffer.strip()
        print("BPM - {}".format(bpm))
        data = bpm
        buffer = ''
    serialIn.close()

@app.route("/")
def main():
    return render_template("test.html")
    pass

@app.route('/<path:path>') # SASS hosting to pass static files as well
def send_js(path):
    return send_from_directory(app.static_folder, path)

@app.route("/bpm")
def run(): 
    bpm = Response(index(), mimetype="text/event-stream")
    bpm.headers.add('Access-Control-Allow-Origin', '*')
    bpm.headers.add('Cache-Control', 'no-cache')

    return bpm

@app.route("/bpmReq")
def req():
    res = jsonify({"data": data})
    res.headers.add('Access-Control-Allow-Origin', '*')
    res.headers.add('Cache-Control', 'no-cache')
    return res

if __name__ == "__main__":
    p1 = threading.Thread(target=serialStream)
    p1.daemon = True
    p1.start()

    app.run(debug=False, host='0.0.0.0', port="5000", threaded=True)
    while(1):
        pass

    p1.join()