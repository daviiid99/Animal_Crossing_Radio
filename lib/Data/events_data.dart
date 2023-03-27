import 'package:animal_crossing_radio/DataBases/events.dart';
import 'package:async/async.dart';
import '../Screens/screen.dart';

class EventsData {


  Map<String, dynamic> events = {
    "assets/res/shizue.png": {
      "message_1": "Te recomiendo escuchar Tota Salsa, es mi canción favorita! ^-^",
      "message_2": "Escuché que Totakeke canta hoy a las 20:00, que emoción!",
      "message_3": "Si ves una canción que te guste, no dudes en comprarla",
    },
    "assets/res/nook.png": {
      "message_1": "Completar tu pasaporte es muy importante, si, si.",
      "message_2": "Visita Almacenes Nook, cambiamos de genero a diario!",
      "message_3": "Si olvidas tu contraseña, puedes recuperarla, pero ten cuidado.",
    },

    "assets/res/totakeke.png": {
      "message_1": "Te espero cada noche a las 20:00",
      "message_2": "Escuché que venden mis canciones, yo no las puse ahí",
      "message_3": "A mi me gusta el café sin leche y sin azúcar, potente.",
    },
  };

  insertEvents() {
    // These add venets into database
    Events currentEvent = Events(message: "message", npc: "npc");
    currentEvent.createTable();

    for (String npc in events.keys) {
      for (String event in events[npc].keys) {
        currentEvent = Events(message: events[npc][event], npc: npc);
        currentEvent.insertEventIntoTable(currentEvent);
      }
    }
  }

}