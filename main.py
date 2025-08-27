# 1. Imports essenciais
import streamlit as st
import os
import google.generativeai as genai
from dotenv import load_dotenv

# 2. Configuração da Página (Aba do Navegador)
# Deve ser o primeiro comando Streamlit do seu script!
# Configuração da página (deve ser a primeira coisa depois dos imports)
# Esta função permite personalizar a aparência da aplicação
st.set_page_config(
    page_title="Chatbot com Google Gemini",  # Título que aparece na aba do navegador
    page_icon="🤖",                          # Ícone da aba do navegador
    layout="wide",                           # Layout amplo ou centralizado
    initial_sidebar_state="expanded"         # Sidebar expandida ou colapsada
)

# 3. Carregamento e Verificação da API Key
load_dotenv()
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")

# Verificar se a API Key está presente
if not GEMINI_API_KEY:
    st.error("🔑 API Key não encontrada. Verifique o arquivo .env.")
    st.stop()

# 4. Configuração da API do Gemini
genai.configure(api_key=GEMINI_API_KEY)

# Função para INICIALIZAR o modelo com configurações específicas
def init_gemini():
    generation_config = {
        "temperature": 0.7,
        "top_p": 0.8,
        "top_k": 40,
        "max_output_tokens": 2048,
    }
    
    model = genai.GenerativeModel(
        model_name="gemini-1.5-flash",
        generation_config=generation_config
    )
    return model

# Função para gerar resposta do chatbot# Função para GERAR uma resposta, com tratamento de erros
    try:
        response = model.generate_content(prompt)
        return response.text
    except Exception as e:
        return f"Erro ao gerar resposta: {str(e)}"

# Configuração da sidebar apenas com estatísticas
with st.sidebar:
    st.header("⚙️ Configurações")
    
    if st.button("🗑️ Limpar Conversa"):
        if 'messages' in st.session_state:
            st.session_state.messages = []
            st.rerun()
    
    st.divider()
    st.subheader("📊 Estatísticas")
    if 'messages' in st.session_state:
        st.metric("Mensagens trocadas", len(st.session_state.messages))
    else:
        st.metric("Mensagens trocadas", 0)

# Inicializar o modelo
if 'model' not in st.session_state:
    with st.spinner("🔄 Inicializando modelo Gemini..."):
        st.session_state.model = init_gemini()

# Interface do usuário principal
st.title("🤖 Chatbot com Google Gemini")
st.write("Bem-vindo ao seu assistente virtual inteligente!")

# Exemplo de como os alunos podem personalizar ainda mais
st.markdown("""
<style>
    .main > div {
        padding-top: 2rem;
    }
</style>
""", unsafe_allow_html=True)

# 1. Inicializa o histórico de mensagens se for a primeira execução
if 'messages' not in st.session_state:
    st.session_state.messages = []
    # Mensagem de boas-vindas personalizada
    st.session_state.messages.append({
        "role": "assistant",
        "content": """👋 Olá! Eu sou seu assistente virtual powered by Google Gemini. 

Posso ajudar você com:
- ❓ Responder perguntas gerais
- 💻 Explicar conceitos de programação
- 📝 Criar e revisar textos
- 🧮 Resolver problemas matemáticos
- 🎨 Ideias criativas

Como posso ajudar você hoje?"""
    })

# 2. Loop que exibe CADA mensagem guardada no histórico
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

# Input do usuário
if prompt := st.chat_input("💬 Digite sua mensagem aqui..."):
    # Adicionar mensagem do usuário
    st.session_state.messages.append({"role": "user", "content": prompt})
    with st.chat_message("user"):
        st.markdown(prompt)
    
    # Gerar resposta do assistente
    with st.chat_message("assistant"):
        with st.spinner("🤔 Pensando..."):
            response = generate_response(st.session_state.model, prompt)
            st.markdown(response)
    
    # Adicionar resposta ao histórico
    st.session_state.messages.append({"role": "assistant", "content": response})