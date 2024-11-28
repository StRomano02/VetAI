from django.db import models

class Centre(models.Model):
    name = models.CharField(max_length=255)
    address = models.TextField()
    phone_number = models.CharField(max_length=20)
    image_url = models.URLField(max_length=500, blank=True, null=True)  # Campo per l'URL dell'immagine

    def __str__(self):
        return self.name