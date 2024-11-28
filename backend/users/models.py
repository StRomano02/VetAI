from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    # Aggiungiamo il ruolo per distinguere i tipi di utenti
    ROLE_CHOICES = [
        ('vet', 'Veterinarian'),
        ('client', 'Client'),
    ]
    role = models.CharField(max_length=10, choices=ROLE_CHOICES, default='client')
    image_url = models.URLField(max_length=500, blank=True, null=True)

    def __str__(self):
        return f"{self.username} ({self.get_role_display()})"