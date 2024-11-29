from rest_framework import serializers
from .models import Animal
from users.models import User
from centers.models import Centre



# class UserSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = User
#         fields = ['id', 'first_name', 'last_name', 'email']

# class CentreSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Centre
#         fields = ['id', 'name', 'address', 'phone_number']





class AnimalSerializer(serializers.ModelSerializer):
    # Relazioni: proprietario e centro
    owner = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.filter(role='client'), 
        required=False, 
        allow_null=True
    )
    centre = serializers.PrimaryKeyRelatedField(
        queryset=Centre.objects.all(), 
        required=False, 
        allow_null=True
    )

    # Inclusione dettagliata per campi JSON o relazioni esterne (se necessario)
    medical_history = serializers.JSONField(required=False)
    diet_notes = serializers.CharField(required=False, allow_blank=True)
    reproduction_notes = serializers.CharField(required=False, allow_blank=True)
    prescribed_drugs = serializers.JSONField(required=False)
    diagnostic_tests = serializers.JSONField(required=False)
    owner_appointments = serializers.JSONField(required=False)

    class Meta:
        model = Animal
        fields = [
            'id', 'name', 'species', 'status', 'breed', 'gender', 
            'birth_date_or_age', 'color_or_marks', 'microchip_number', 
            'current_weight', 'photo_url', 'owner', 'centre', 
            'context', 'medical_history', 'diet_notes', 'reproduction_notes', 
            'prescribed_drugs', 'diagnostic_tests', 'owner_appointments'
        ]