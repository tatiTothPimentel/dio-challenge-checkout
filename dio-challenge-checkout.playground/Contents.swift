import Foundation

// Criação de um enum para controlar qual mensagem de sucesso será exibida dependendo o tipo de pagamento
enum Method {
    case creditCard
    case bankSlip
    
    var menssageSucess: String {
        switch self {
        case .creditCard:
            return "Pagamento realizado com sucesso no cartão de crédito"
        case .bankSlip:
            return "Enviamos um e-mail para a realização do pagamento via boleto bancário"
        }
    }
}

// Definição do protocolo método de pagamento
protocol PaymentMethod {
    func pay(amount: Double, completion: @escaping (Result<Method, Error>) -> Void)
}

class CreditCard: PaymentMethod {
    var error: Error?
    
    func pay(amount: Double, completion: @escaping (Result<Method, Error>) -> Void) {
        // Simulação de uma chamada assíncrona
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: { [weak self] in
            if self?.error == nil {
                completion(.success(.creditCard))
                self?.error = NSError(domain: "Pagamento duplicado", code: 400)
            } else {
                completion(.failure(self?.error ?? NSError()))
            }
        })
    }
}

class BankSlip: PaymentMethod {
    var error: Error?

    func pay(amount: Double, completion: @escaping (Result<Method, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: { [weak self] in
            if self?.error == nil {
                completion(.success(.bankSlip))
                self?.error = NSError(domain: "O boleto para a realização do pagamento já foi enviado, verifique sua caixa de spam", code: 400)
            } else {
                completion(.failure(self?.error ?? NSError()))
            }
        })
    }
}

// Criação do objeto produto
struct Product {
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}

class Cart {
    var items: [Product]
    var paymentMethod: PaymentMethod
    
    init(items: [Product], paymentMethod: PaymentMethod) {
        self.items = items
        self.paymentMethod = paymentMethod // Injeção de depêndencia para efetuar o pagamento
    }
    
    func checkout() {
        // Somando o valor total do preço dos produtos
        let amount = items.reduce(0.0, { partialResult, item in partialResult + item.price })
        // Inicio da simulação de um fluxo de tela
        print("## Mostrar o loading")
        paymentMethod.pay(amount: amount, completion: { result in
            switch result {
            case .success(let data):
                switch data {
                case .creditCard:
                    print("\(data.menssageSucess) no valor de \(amount)")
                case .bankSlip:
                    print(data.menssageSucess)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            print("## Remove o loading")
            // Final da simulação de um fluxo de tela
        })
    }
}

// Neste cenário criamos items para adicionar no carrinho, um método de pagamento e adicionamos os items e o método no carinho.
let itemsTati = [Product(name: "iPhone", price: 3000.0), Product(name: "MacBook", price: 5000.0)]
let paymentMethodTati = BankSlip()
let cartTati = Cart(items: itemsTati, paymentMethod: paymentMethodTati)

// Neste momento chamamos o método checkout() para que o mesmo possa realizar o pagamento, fazemos isso duas vezes para simular os dois resultados: sucess e error
cartTati.checkout()
cartTati.checkout()

let itemsAndre = [Product(name: "Fone de ouvido", price: 500.0), Product(name: "Mouse", price: 1000.0)]
let paymentMethodAndre = CreditCard()
let cartAndre = Cart(items: itemsAndre, paymentMethod: paymentMethodAndre)
cartAndre.checkout()
cartAndre.checkout()

