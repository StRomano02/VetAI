from django.conf import settings
from django.db import models
from django.contrib.auth.models import User

class Shelter(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    address = models.CharField(max_length=255)
    contact_info = models.CharField(max_length=255)
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)  # Riferimento corretto

    def __str__(self):
        return self.name

class Animal(models.Model):
    CATEGORY_CHOICES = [
        ('dog', 'Dog'),
        ('cat', 'Cat'),
        ('other', 'Other'),
    ]

    name = models.CharField(max_length=255)
    age = models.PositiveIntegerField()
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES)
    description = models.TextField()
    shelter = models.ForeignKey(Shelter, on_delete=models.CASCADE, related_name='animals')

    def __str__(self):
        return self.name
