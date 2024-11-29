from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status, viewsets
#from rest_framework.permissions import IsAuthenticated  # Importa il permesso IsAuthenticated
from animals.models import Animal
from users.models import User
from animals.serializers import AnimalSerializer
from centers.models import Centre


class AnimalViewSet(viewsets.ModelViewSet):
    """
    ViewSet per gestire gli animali. Permette di creare, leggere, aggiornare e eliminare animali.
    """
    queryset = Animal.objects.all()
    serializer_class = AnimalSerializer
    #permission_classes = [IsAuthenticated]  # Abilita l'accesso autenticato per maggiore sicurezza

    @action(detail=True, methods=['post'], url_path='assign-owner')
    def assign_owner(self, request, pk=None):
        """
        Permette di assegnare un proprietario a un animale.
        """
        animal = self.get_object()
        owner_id = request.data.get('owner_id')

        if not owner_id:
            return Response({'error': 'owner_id is required'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            owner = User.objects.get(id=owner_id, role='client')  # Controlla che sia un client
        except User.DoesNotExist:
            return Response({'error': 'Proprietario non trovato o ruolo non valido'}, status=status.HTTP_404_NOT_FOUND)

        animal.owner = owner
        animal.save()
        return Response({'message': f'Proprietario {owner.first_name} {owner.last_name} assegnato all\'animale {animal.name}'})

    @action(detail=True, methods=['post'], url_path='assign-centre')
    def assign_centre(self, request, pk=None):
        """
        Permette di assegnare un centro a un animale.
        """
        animal = self.get_object()
        centre_id = request.data.get('centre_id')

        if not centre_id:
            return Response({'error': 'centre_id is required'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            centre = Centre.objects.get(id=centre_id)
        except Centre.DoesNotExist:
            return Response({'error': 'Centro non trovato'}, status=status.HTTP_404_NOT_FOUND)

        animal.centre = centre
        animal.save()
        return Response({'message': f'Centro {centre.name} assegnato all\'animale {animal.name}'})