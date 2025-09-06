import pytest
from unittest.mock import Mock, patch
import sys
import os

# Adicionar o diretório atual ao path para permitir importação dos módulos
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

@pytest.fixture
def mock_streamlit():
    """Fixture para mockar o Streamlit"""
    with patch('streamlit.set_page_config'), \
         patch('streamlit.error'), \
         patch('streamlit.stop'), \
         patch('streamlit.spinner'), \
         patch('streamlit.title'), \
         patch('streamlit.write'), \
         patch('streamlit.markdown'), \
         patch('streamlit.sidebar'), \
         patch('streamlit.header'), \
         patch('streamlit.button'), \
         patch('streamlit.divider'), \
         patch('streamlit.subheader'), \
         patch('streamlit.metric'), \
         patch('streamlit.chat_message'), \
         patch('streamlit.chat_input'), \
         patch('streamlit.rerun'), \
         patch('streamlit.session_state', {}):
        yield

@pytest.fixture
def mock_genai():
    """Fixture para mockar o Google Generative AI"""
    with patch('google.generativeai.configure'), \
         patch('google.generativeai.GenerativeModel') as mock_model:
        yield mock_model

@pytest.fixture
def mock_environment():
    """Fixture para mockar variáveis de ambiente"""
    with patch.dict(os.environ, {'GEMINI_API_KEY': 'test_api_key_12345'}):
        yield

@pytest.fixture
def sample_messages():
    """Fixture com mensagens de exemplo para testes"""
    return [
        {"role": "user", "content": "Como criar testes unitários?"},
        {"role": "assistant", "content": "Para criar testes unitários, você deve..."},
        {"role": "user", "content": "E testes de integração?"}
    ]

@pytest.fixture
def mock_model():
    """Fixture para criar um mock do modelo Gemini"""
    model = Mock()
    response = Mock()
    response.text = "Resposta mockada do modelo"
    model.generate_content.return_value = response
    return model
