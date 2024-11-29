from django.db import models
from users.models import User  

class Centre(models.Model):
    name = models.CharField(max_length=255)
    address = models.TextField()
    phone_number = models.CharField(max_length=20)
    image_url = models.URLField(max_length=500, blank=True, null=True)  

    veterinarians = models.ManyToManyField(
        User,
        limit_choices_to={'role': 'vet'},
        related_name='centres'
    )

    def __str__(self):
        return self.name