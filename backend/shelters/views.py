from rest_framework import viewsets, permissions
from .models import Shelter
from .serializers import ShelterSerializer
from .models import Animal
from .serializers import AnimalSerializer

class ShelterViewSet(viewsets.ModelViewSet):
    queryset = Shelter.objects.all()
    serializer_class = ShelterSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)  # Associa l'utente loggato come proprietario

from rest_framework import viewsets, permissions
from .models import Animal
from .serializers import AnimalSerializer

class AnimalViewSet(viewsets.ModelViewSet):
    queryset = Animal.objects.all()
    serializer_class = AnimalSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        # Permetti ai veterinari di vedere solo gli animali dei loro rifugi
        if self.request.user.is_authenticated:
            return Animal.objects.filter(shelter__owner=self.request.user)
        return Animal.objects.none()
