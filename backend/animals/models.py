from django.db import models
from users.models import User
from centers.models import Centre

class Animal(models.Model):
    
    CONTEXT_CHOICES = [
        ('registered', 'Registered'),
        ('adoptable', 'Adoptable'),
        ('under_care', 'Under Care'),
    ]
    
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
    owner_appointments = models.JSONField(blank=True, null=True) 
    medical_history = models.JSONField(blank=True, null=True)  
    diet_notes = models.TextField(blank=True, null=True)
    reproduction_notes = models.TextField(blank=True, null=True)
    prescribed_drugs = models.JSONField(blank=True, null=True) 
    diagnostic_tests = models.JSONField(blank=True, null=True)  
    photo_url = models.URLField(max_length=500, blank=True, null=True)  
    
    
    owner = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        limit_choices_to={'role': 'client'},
        related_name='owned_animals'
    )
    
    # Centro di associazione
    centre = models.ForeignKey(
        Centre,
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name='animals'
    )
    
    # Stato dell'animale
    context = models.CharField(
        max_length=50,
        choices=CONTEXT_CHOICES,
        default='registered'
    )
    

    def __str__(self):
        return self.name