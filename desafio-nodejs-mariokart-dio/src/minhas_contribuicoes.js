/**
 * Modificações realizadas por iAiBel
 * - Inclusão de novos personagens
 * - Corrida com múltiplos competidores
 * - Ranking parcial a cada rodada
 */
const player1 = { NOME: "Mario", VELOCIDADE: 4, MANOBRABILIDADE: 3, PODER: 3, PONTOS: 0 };
const player2 = { NOME: "Luigi", VELOCIDADE: 3, MANOBRABILIDADE: 4, PODER: 4, PONTOS: 0 };
const player3 = { NOME: "Yoshi", VELOCIDADE: 2, MANOBRABILIDADE: 4, PODER: 3, PONTOS: 0 };
const player4 = { NOME: "Bowser", VELOCIDADE: 5, MANOBRABILIDADE: 2, PODER: 5, PONTOS: 0 };
const player5 = { NOME: "Peach", VELOCIDADE: 3, MANOBRABILIDADE: 4, PODER: 2, PONTOS: 0 };
const player6 = { NOME: "Donkey Kong", VELOCIDADE: 2, MANOBRABILIDADE: 2, PODER: 5, PONTOS: 0 };

const players = [player1, player2, player3, player4, player5, player6];

async function rollDice() {
  return Math.floor(Math.random() * 6) + 1;
}

async function getRandomBlock() {
  const random = Math.random();
  if (random < 0.33) return "RETA";
  if (random < 0.66) return "CURVA";
  return "CONFRONTO";
}

async function logRollResult(characterName, attributeName, diceResult, attributeValue) {
  console.log(
    `${characterName} 🎲 rolou ${diceResult} + ${attributeValue} (${attributeName}) = ${diceResult + attributeValue}`
  );
}

async function playRaceEngine(playersList) {
  // garante pontos zerados antes da corrida
  playersList.forEach(p => (p.PONTOS = 0));

  for (let round = 1; round <= 5; round++) {
    console.log(`\n🏁 Rodada ${round}`);

    const block = await getRandomBlock();
    console.log(`Bloco: ${block}`);

    // calcula resultado de cada player na rodada
    const results = await Promise.all(
      playersList.map(async p => {
        const dice = await rollDice();
        let total = dice;
        let attributeName = "";
        let attributeValue = 0;

        if (block === "RETA") {
          attributeName = "velocidade";
          attributeValue = p.VELOCIDADE;
          total += p.VELOCIDADE;
        } else if (block === "CURVA") {
          attributeName = "manobrabilidade";
          attributeValue = p.MANOBRABILIDADE;
          total += p.MANOBRABILIDADE;
        } else if (block === "CONFRONTO") {
          attributeName = "poder";
          attributeValue = p.PODER;
          total += p.PODER;
        }

        await logRollResult(p.NOME, attributeName, dice, attributeValue);
        return { player: p, total };
      })
    );

    // atribui pontos ao(s) vencedor(es) da rodada (todos empatados ganham 1 ponto)
    const max = Math.max(...results.map(r => r.total));
    results.forEach(r => { if (r.total === max) r.player.PONTOS++; });

    console.log("🏎️ Ranking parcial:", playersList.map(p => `${p.NOME}: ${p.PONTOS}`).join(" | "));
    console.log("-----------------------------");
  }
}

async function declareWinner(playersList) {
  console.log("\nResultado final:");
  playersList.forEach(p => console.log(`${p.NOME}: ${p.PONTOS} ponto(s)`));

  const max = Math.max(...playersList.map(p => p.PONTOS));
  const winners = playersList.filter(p => p.PONTOS === max);

  if (winners.length === 1) {
    console.log(`\n${winners[0].NOME} venceu a corrida! Parabéns! 🏆`);
  } else {
    console.log(
      "\nA corrida terminou em empate (empatar é o mesmo que perder): " + winners.map(w => w.NOME).join(", ")
    );
  }
}

(async function main() {
  console.log(`🏁🏁 Corrida entre todos os personagens começando...\n`);
  await playRaceEngine(players);
  await declareWinner(players);
})();
