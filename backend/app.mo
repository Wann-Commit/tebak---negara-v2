import Nat "mo:base/Nat";
import Random "mo:base/Random";
import Text "mo:base/Text";

actor {
  // Daftar negara
  let countries = [
    "Indonesia",
    "Malaysia",
    "Singapura",
    "Thailand",
    "Vietnam"
    // Tambahkan negara lain sesuai kebutuhan
  ];

  // Negara yang sedang ditebak (disimpan di stable var agar persist)
  stable var answer : Text = "";

  // Fungsi untuk memilih negara secara acak
  public func pickCountry() : async Text {
    let n = countries.size();
    let entropy = await Random.blob();
    let random = Random.Finite(entropy);
    let idxOpt = random.range(3); // 3 bit cukup untuk 5 negara
    let idx = switch idxOpt {
      case (?i) { i % n };
      case null { 0 };
    };
    answer := countries[idx];
    return "Negara sudah dipilih. Silakan tebak!";
  };

  // Fungsi untuk menebak negara
  public query func guessCountry(guess : Text) : async Text {
    if (Text.equal(Text.toLowercase(guess), Text.toLowercase(answer))) {
      return "Benar! Jawabannya adalah " # answer # ".";
    } else {
      return "Salah, coba lagi!";
    }
  };

  // Fungsi untuk melihat jawaban (debug)
  public query func getAnswer() : async Text {
    answer
  };
}