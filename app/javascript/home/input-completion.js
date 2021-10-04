$(function () {

    var wordlist = [
        "あいうえお",
        "かきくけこ",
        "さしすせそ",
        "たちつてと",
        "なにぬねの",
        "はひふへほ",
        "まみむめも",
        "やゆよ",
        "らりるれろ",
        "わをん",
        "あかさたなはまやらわ",
        "いきしちにひみり",
        "うくすつぬふむゆる",
        "えけせてねへめれ",
        "おこそとのほもよろを",
        "ん",
        "abcdefg",
        "hijklmnop",
        "qrstuv",
        "wxyz",
        "abc",
        "def",
        "ghi",
        "jkl",
        "mno",
        "pqr",
        "stu",
        "vwx",
        "yz",
        "漢字１",
        "漢字２",
        "漢字３"
      ];
    $('#sbox2').autocomplete({
        source: wordlist
    });
});