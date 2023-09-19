import pandas as pd
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    
    return 'Minha AC1: Aluno Gregory Cavalcanti - RA: 2202566'


@app.route('/jogos') 
def jogos():
    dados = pd.read_csv('.\\futebol.csv', sep=';', encoding='utf-8')
    dados = dados.replace({'á':'a', 'ã':'a', 'â':'a', 'í':'i', '\W':'', 'ÅŸ':'s', 'Ä°':'I', 'Ä±':'i', 'Ã¶':'o', 'Ã§':'c',
                       'ÄŸ':'g', 'Ã¼':'u', 'Ã©':'e', 'Ã¡':'a', 'Ã³':'o', 'Ã±':'nh', '&':'', 'Ã…Ë†':'n', 'Ã§':'c',
                       ' ':'', 'Ã­':'i', 'Ã£':'a', 'Ãº':'u', 'Ã':'a', 'Ãª':'e', 'Ã‘':'N', 'aÂ¢':'a', 'aÂª':'e',
                       'aÂ�':'a', "á":"a", "é":"e", "í":"i", "ó":"o", "ú":"u", "ã":"a", "õ":"o", "aª":"e", "á":"a",
                       "é":"e","í":"i", "ó":"o", "ú":"u", "ã":"a", "õ":"o", "ê":"e", "â":"a", "ô":"o", "ê":"e",
                       "â":"a", "ô":"o"}, regex=True)
    dados = dados[['date_GMT', 'home_team_name', 'away_team_name', 'home_team_goal_count', 'away_team_goal_count']]
    dados['jogo'] = dados['home_team_name'].astype(str) + ' X ' + dados['away_team_name'].astype(str)
    dados['placar'] = dados['home_team_goal_count'].astype(str) + ' - ' + dados['away_team_goal_count'].astype(str)
    
    return dados[['jogo', 'placar', 'date_GMT', 'home_team_name', 'away_team_name']].to_json(orient='index')


@app.route('/flu')
def flu():
    dados = pd.read_csv('.\\futebol.csv', sep=';', encoding='utf-8')
    dados_flu = dados[['home_team_name','home_team_goal_count','away_team_goal_count','date_GMT']][dados['home_team_name'] == 'Fluminense'].groupby(['home_team_name']).sum()
    
    return dados_flu.to_json()


@app.route('/cor')
def cor():
    dados = pd.read_csv('.\\futebol.csv', sep=';', encoding='utf-8')
    dados_cor = dados[['home_team_name','home_team_goal_count','away_team_goal_count','date_GMT']][dados['home_team_name'] == 'Corinthians'].groupby(['home_team_name']).sum()
        
    return dados_cor.to_json()


@app.route('/bah')
def bah():
    dados = pd.read_csv('.\\futebol.csv', sep=';', encoding='utf-8')
    dados_bah = dados[['home_team_name','home_team_goal_count','away_team_goal_count','date_GMT']][dados['home_team_name'] == 'Bahia'].groupby(['home_team_name']).sum()
    
    return dados_bah.to_json()


@app.route('/juizes')
def juizes():
        df_juiz = pd.read_csv('.\\futebol.csv', sep=';', encoding='utf-8')
        dados_juiz = df_juiz.groupby('referee')['home_team_goal_count'].agg(['count']).reset_index().rename(mapper={'referee' : 'juiz', 'count' : 'partidas'},axis=1)

        return dados_juiz.to_json(orient='index')


if __name__ == "__main__":
    app.run(debug=True)