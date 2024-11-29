from rest_framework import serializers
from .models import Centre
from users.models import User

class VeterinarianSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'email']

class CentreSerializer(serializers.ModelSerializer):
    veterinarians = VeterinarianSerializer(many=True, read_only=True)

    class Meta:
        model = Centre
        fields = ['id', 'name', 'address', 'phone_number', 'image_url', 'veterinarians']