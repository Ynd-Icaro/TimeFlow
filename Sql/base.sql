-- Tabela de Usuários
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user', -- Pode ser 'user' ou 'admin'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Função para atualizar o timestamp automaticamente
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Adicionar gatilho (trigger) para atualizar automaticamente o campo updated_at
CREATE TRIGGER update_user_modtime
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();

-- Tabela de Agendamentos
CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'scheduled', -- Pode ser 'scheduled', 'completed', 'cancelled'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Adicionar gatilho (trigger) para atualizar automaticamente o campo updated_at
CREATE TRIGGER update_appointment_modtime
BEFORE UPDATE ON appointments
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();

-- Tabela de Notificações
CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    appointment_id INT NOT NULL,
    notification_type VARCHAR(20) NOT NULL, -- Pode ser 'email' ou 'sms'
    message TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'pending', -- Pode ser 'pending', 'sent', 'failed'
    sent_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE
);

-- Adicionar gatilho (trigger) para atualizar automaticamente o campo updated_at
CREATE TRIGGER update_notification_modtime
BEFORE UPDATE ON notifications
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();

-- Tabela de Recuperação de Senhas
CREATE TABLE password_resets (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

