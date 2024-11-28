from rest_framework import serializers
from .models import User

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'name', 'surname', 'email', 'role', 'image_url', 'password']
        extra_kwargs = {
            'password': {'write_only': True},
            'image_url': {'required': False, 'allow_null': True},
        }

    def create(self, validated_data):
        user = User.objects.create_user(
            email=validated_data['email'],
            password=validated_data['password'],
            name=validated_data['name'],
            surname=validated_data['surname'],
            role=validated_data['role'],
            image_url=validated_data.get('image_url'),
        )
        return user