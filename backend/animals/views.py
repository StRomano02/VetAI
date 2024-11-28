from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from .models import Animal
from .serializers import AnimalSerializer

class AnimalViewSet(viewsets.ModelViewSet):
    """
    ViewSet per gestire gli animali. Permette di creare, leggere, aggiornare e eliminare animali.
    """
    queryset = Animal.objects.all()
    serializer_class = AnimalSerializer
    permission_classes = [IsAuthenticated]  # Abilita l'accesso autenticato per maggiore sicurezza