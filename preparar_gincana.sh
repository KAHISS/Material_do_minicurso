#!/usr/bin/env bash
# Gincana Linux (individual, 30 min): prepara os arquivos das corridas e da rodada final em ~/gincana
# Rode este script em cada computador antes de começar (ou de novo, para reiniciar).
# Ele cria as pastas das rodadas 1 a 4 e da rodada final (r5). O mestre confere os resultados olhando a tela.

set -e

if [ -z "$HOME" ]; then
  echo "A variável HOME não está definida."
  exit 1
fi

BASE="$HOME/gincana"

# Garante que a senha do cofre (sem permissão) não atrapalhe o reinício
if [ -d "$BASE" ]; then
  chmod -R u+rwX "$BASE" 2>/dev/null || true
fi
rm -rf "$BASE"

# ------------------------------------------------ Rodada 1: Navegação
mkdir -p "$BASE/r1/acampamento/barraca"
mkdir -p "$BASE/r1/floresta/trilha/rio/ponte"
mkdir -p "$BASE/r1/floresta/trilha/caverna"
mkdir -p "$BASE/r1/biblioteca"

echo "O código é: CAIXA42" > "$BASE/r1/floresta/trilha/rio/ponte/.codigo_secreto"
echo "Este código é falso. Procure melhor!" > "$BASE/r1/acampamento/.bilhete_falso"
echo "Eco, eco, eco... nada por aqui." > "$BASE/r1/floresta/trilha/caverna/.eco"
echo "Uma lanterna sem pilhas." > "$BASE/r1/acampamento/barraca/lanterna.txt"
echo "Livros empoeirados." > "$BASE/r1/biblioteca/livros.txt"

# ------------------------------------------ Rodada 2: Arquivos (a bagunça)
mkdir -p "$BASE/r2/bagunca/lixo"

echo "Relatório do mês." > "$BASE/r2/bagunca/relatorio.txt"
echo "Anotações da reunião." > "$BASE/r2/bagunca/notas.txt"
echo "Lista de compras." > "$BASE/r2/bagunca/lista.txt"
echo "Sistema iniciado." > "$BASE/r2/bagunca/sistema.log"
echo "Acesso registrado." > "$BASE/r2/bagunca/acesso.log"
echo "Rascunho velho." > "$BASE/r2/bagunca/lixo/rascunho.txt"
echo "Foto corrompida." > "$BASE/r2/bagunca/lixo/foto.tmp"
echo "Backup antigo." > "$BASE/r2/bagunca/lixo/backup.old"

# ------------------------------------------ Rodada 3: Textos (o log)
mkdir -p "$BASE/r3"

for i in $(seq 1 200); do
  if [ $((i % 13)) -eq 0 ]; then
    echo "[linha $i] ERRO: falha ao processar a requisição"
  elif [ $((i % 47)) -eq 0 ]; then
    echo "[linha $i] aviso: erro de digitação ignorado"
  else
    echo "[linha $i] INFO: operação concluída com sucesso"
  fi
done > "$BASE/r3/servidor.log"

# ------------------------------------------ Rodada 4: Permissões (o cofre)
mkdir -p "$BASE/r4"

echo "sesamo" > "$BASE/r4/senha.txt"
chmod 000 "$BASE/r4/senha.txt"

cat > "$BASE/r4/cofre.sh" << 'EOF'
#!/usr/bin/env bash
read -r -p "Diga a senha: " senha
if [ "$senha" != "sesamo" ]; then
  echo "O cofre não se mexe. Senha errada!"
  exit 1
fi
echo "CLIC! O cofre abriu!"
echo "CÓDIGO: ZEBRA77"
EOF
chmod 644 "$BASE/r4/cofre.sh"

# ------------------------------------------ Rodada Final: Operação Pinguim Perdido
mkdir -p "$BASE/r5/acampamento"
mkdir -p "$BASE/r5/caverna"
mkdir -p "$BASE/r5/biblioteca"
mkdir -p "$BASE/r5/cofre"

cat > "$BASE/r5/acampamento/.bilhete_secreto" << 'EOF'
Você achou o bilhete escondido!

PALAVRA1: PINGUIM

O Tux foi para a caverna. Siga as pistas!
EOF
echo "Nada por aqui... procure melhor." > "$BASE/r5/acampamento/mapa_falso.txt"

echo "Ouro, moedas e um peixe de chocolate." > "$BASE/r5/caverna/tesouro.txt"
echo "CUIDADO: arquivo armadilha!" > "$BASE/r5/caverna/armadilha.txt"
echo "Uma chave enferrujada." > "$BASE/r5/caverna/chave_velha"

for i in $(seq 1 60); do
  if [ "$i" -eq 37 ]; then
    echo "Dia $i: achei um papel amassado com a frase PALAVRA3: PARA"
  else
    echo "Dia $i: o pinguim andou pela floresta e não achou nada de especial."
  fi
done > "$BASE/r5/biblioteca/diario_do_pinguim.txt"

echo "abracadabra" > "$BASE/r5/cofre/senha.txt"
chmod 000 "$BASE/r5/cofre/senha.txt"

cat > "$BASE/r5/cofre/cofre.sh" << 'EOF'
#!/usr/bin/env bash
read -r -p "Diga a senha: " senha
if [ "$senha" != "abracadabra" ]; then
  echo "O cofre não se mexe. Senha errada!"
  exit 1
fi
echo "CLIC! O cofre abriu!"
echo "CÓDIGO: FOCA99"
EOF
chmod 644 "$BASE/r5/cofre/cofre.sh"

echo "Gincana preparada em $BASE"
