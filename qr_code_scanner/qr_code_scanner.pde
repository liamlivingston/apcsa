import processing.video.*;
import pqrcode.*;

Capture video;
Decoder decoder;
int width = 320;
int height = 240;
String status = "Take a picture with the spacebar";

void setup() {//sets up the decoder and video window (320x240px)
  size(width, height);
  video = new Capture(this, width, height);
  decoder = new Decoder(this);
  video.start();
}

void decoderEvent(Decoder decoder) {
  status = decoder.getDecodedString(); 
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  background(0);
  image(video, 0, 0);
  text(status, 12, height-6);
  if (decoder.decoding()) {
    status = "Decoding";
  }

}

void keyReleased() {
  switch (key) {
  case ' '://saved the current video frame and calls the decoder with it
    PImage frame = createImage(width,height,RGB);
    frame.copy(video, 0,0,width,height,0,0,width,height);
    frame.updatePixels();
    decoder.decodeImage(frame);
    break;
  case 'o': //opens the link in the decoded data
    if (!status.equals("Take a picture with the spacebar") && !status.equals("No QRcode image found") && !status.equals("Decoding image")) {
      link(status);
    }
    
  }
}
