# Sistema de Pagamento Simples

Este é um projeto de exemplo de um sistema de pagamento simples em Swift que permite aos clientes realizar pagamentos com dois métodos diferentes: cartão de crédito e boleto bancário. O projeto também demonstra como lidar com chamadas assíncronas e simular cenários de sucesso e erro durante o pagamento.

## Estrutura do Projeto

O projeto consiste em várias partes:

- `Method`: Um enum que controla qual mensagem de sucesso será exibida dependendo do tipo de pagamento selecionado.

- `PaymentMethod`: Um protocolo que define a estrutura básica de um método de pagamento. Possui uma função `pay` que simula o pagamento e retorna um resultado assíncrono.

- `CreditCard` e `BankSlip`: Classes que implementam o protocolo `PaymentMethod`. Elas simulam pagamentos com cartão de crédito e boleto bancário, respectivamente. Ambas realizam chamadas assíncronas com atraso de 5 segundos para simular o processamento do pagamento.

- `Product`: Uma estrutura que representa um produto com nome e preço.

- `Cart`: Uma classe que representa o carrinho de compras. Permite adicionar produtos e efetuar o pagamento. Dependendo do método de pagamento selecionado, as mensagens de sucesso ou erro são exibidas.

## Como Usar

1. Clone ou faça o download do projeto em seu ambiente de desenvolvimento Swift.

2. Abra o projeto em seu ambiente de desenvolvimento preferido.

3. Execute o projeto para ver as simulações de pagamento em ação. Você pode personalizar as simulações de sucesso e erro conforme necessário.

4. Experimente melhorias para tornar o sistema de pagamento mais completo e funcional.

Este pequeno projeto foi realizado como um desafio para o aprendizado e experimentação de programação orientada a protocolos em Swift. Divirta-se aprimorando o mesmo se desejar!

