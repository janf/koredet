function parse_text(text) {

}



function set_textfield_value(fld, txt) {
   fld.val(txt) 
}


function  sayhello(fld) {
   set_textfield_value(fld, "Hello speeking world")
};


function startspeech(lang, fld_text, fld_info) {
    var final_transcript = ""
    var ignore_onend = false
    if (!('webkitSpeechRecognition' in window)) {
        set_textfield_value(fld_info, "Speech recognition not available");
        alert("No speech possible")
    } else {
        var recognition = new webkitSpeechRecognition();
        recognition.continuous = true;
        recognition.interimResults = false;
      
        recognition.onstart = function() {
            recognizing = true;
            set_textfield_value(fld_info, "...Speech recognition started..");
        };

        recognition.onerror = function(event) {
            if (event.error == 'no-speech') {
                set_textfield_value(fld_info, 'info_no_speech');
                ignore_onend = true;
            }
            if (event.error == 'audio-capture') {
                set_textfield_value(fld_info, 'info_no_microphone');
                ignore_onend = true;
            }
            if (event.error == 'not-allowed') {
                if (event.timeStamp - start_timestamp < 100) {
                set_textfield_value(fld_info, 'info_blocked');
                } else {
                set_textfield_value(fld_info, 'info_denied');
              }
                ignore_onend = true;
            }
        };

        recognition.onend = function() {
            recognizing = false;
            if (ignore_onend) {
                return;
            }
            if (!final_transcript) {
                set_textfield_value(fld_info, '*** Press Speech input to add more item ***');
                return;
            }
            //alert("Speech recognition ended")
            set_textfield_value(fld_info, '');
        };

        recognition.onresult = function(event) {
            var interim_transcript = '';
            
            console.log("Events result length: " + event.results.length)

            for (var i = event.resultIndex; i < event.results.length; ++i) {
                console.log("Processing event:" + i)
                if (event.results[i].isFinal) {
                    final_transcript += event.results[i][0].transcript;
                    set_textfield_value(fld_text, final_transcript);
                    console.log("New final text: " + final_transcript)
                    data = final_transcript
                    var cust_event = new CustomEvent("new-text-available", { "detail": data });
                    document.dispatchEvent(cust_event);
                    final_transcript = ''
                } else {
                    interim_transcript += event.results[i][0].transcript;
                    console.log("New interim text: " + interim_transcript)
                }
            }
        } 
        recognition.start();   
        
    };
};


