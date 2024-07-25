-- Índices para melhorar a performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_appointments_user_id ON appointments(user_id);
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_appointment_id ON notifications(appointment_id);
