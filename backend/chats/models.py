from django.db import models
from django.contrib.auth.models import User

class Chat(models.Model):
    name = models.CharField(max_length=255)  # Nome della chat
    image_url = models.URLField(max_length=500, blank=True, null=True)  # URL immagine
    last_message = models.TextField(blank=True, null=True)  # Ultimo messaggio
    last_message_time = models.DateTimeField(auto_now=True)  # Timestamp dell'ultimo messaggio

    def __str__(self):
        return self.name


class Message(models.Model):
    chat = models.ForeignKey(Chat, related_name='messages', on_delete=models.CASCADE)  # Relazione con Chat
    sender = models.CharField(max_length=255)  # Nome del mittente
    text = models.TextField()  # Testo del messaggio
    timestamp = models.DateTimeField(auto_now_add=True)  # Data e ora del messaggio

    def __str__(self):
        return f"{self.sender}: {self.text[:50]}..."