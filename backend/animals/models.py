from django.db import models

class Animal(models.Model):
    name = models.CharField(max_length=255)
    species = models.CharField(max_length=255)
    status = models.CharField(max_length=255)
    breed = models.CharField(max_length=255, blank=True, null=True)
    gender = models.CharField(max_length=50, blank=True, null=True)
    birth_date_or_age = models.CharField(max_length=255, blank=True, null=True)
    color_or_marks = models.TextField(blank=True, null=True)
    microchip_number = models.CharField(max_length=50, blank=True, null=True)
    current_weight = models.CharField(max_length=50, blank=True, null=True)
    owner_name = models.CharField(max_length=255, blank=True, null=True)
    owner_contact = models.CharField(max_length=255, blank=True, null=True)
    owner_address = models.TextField(blank=True, null=True)
    owner_appointments = models.JSONField(blank=True, null=True)  # Lista di appuntamenti
    medical_history = models.JSONField(blank=True, null=True)  # Mappa della storia medica
    diet_notes = models.TextField(blank=True, null=True)
    reproduction_notes = models.TextField(blank=True, null=True)
    prescribed_drugs = models.JSONField(blank=True, null=True)  # Lista di farmaci prescritti
    diagnostic_tests = models.JSONField(blank=True, null=True)  # Lista di test diagnostici
    photo_url = models.URLField(max_length=500, blank=True, null=True)  # URL della foto

    def __str__(self):
        return self.name