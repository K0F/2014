import javax.speech.*;
import javax.speech.synthesis.*;
import java.util.Locale;

void setup(){

try
    {
      // Create a synthesizer for English
      Synthesizer synth = Central.createSynthesizer(
      new SynthesizerModeDesc(Locale.ENGLISH));
      synth.allocate();
      synth.resume();

      // Speak the "Hello, Unleashed Reader" string
      synth.speakPlainText("Hello, Unleashed Reader!", null);
      System.out.println(
        "You should be hearing Hello, Unleashed Reader now");

      // Wait till speaking is done
      synth.waitEngineState(Synthesizer.QUEUE_EMPTY);

      // release the resources
      synth.deallocate();
    } catch (Exception e)
    {
      e.printStackTrace();
    }
}


