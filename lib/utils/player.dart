enum PaymentMode { Pay, Collect }

class Transaction {
  int amount;
  PaymentMode mode;
  String opponentId;

  Transaction(this.amount, this.mode, this.opponentId);
}

class Player {
  String cardId;
  String name;
  int amount;
  List<Transaction> transactions;

  Player(String cardId, String name, int amount) {
    this.cardId = cardId;
    this.name = name;
    this.amount = amount;
    
    transactions = [ Transaction(amount, PaymentMode.Collect, "Bank") ];
  }

  collect(int amount, String opponentId) {
    this.amount += amount;
    transactions.add(Transaction(amount, PaymentMode.Collect, opponentId));
  }

  pay(int amount, String opponentId) {
    this.amount -= amount;
    transactions.add(Transaction(amount, PaymentMode.Pay, opponentId));
  }
}