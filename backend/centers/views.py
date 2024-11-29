from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import Centre
from .serializers import CentreSerializer
from users.models import User

class CentreViewSet(viewsets.ModelViewSet):
    queryset = Centre.objects.all()
    serializer_class = CentreSerializer

    @action(detail=True, methods=['post'], url_path='add-vet')
    def add_vet(self, request, pk=None):
        """
        Aggiunge un veterinario a un centro specifico.
        """
        centre = self.get_object()
        vet_id = request.data.get('vet_id')
        
        try:
            vet = User.objects.get(id=vet_id, role='vet')
        except User.DoesNotExist:
            return Response({'error': 'Veterinario non trovato o ruolo non valido.'}, status=status.HTTP_404_NOT_FOUND)

        centre.veterinarians.add(vet)
        return Response({'message': f'Il veterinario {vet.first_name} {vet.last_name} è stato aggiunto al centro {centre.name}.'})

    @action(detail=True, methods=['post'], url_path='remove-vet')
    def remove_vet(self, request, pk=None):
        """
        Rimuove un veterinario da un centro specifico.
        """
        centre = self.get_object()
        vet_id = request.data.get('vet_id')
        
        try:
            vet = User.objects.get(id=vet_id, role='vet')
        except User.DoesNotExist:
            return Response({'error': 'Veterinario non trovato o ruolo non valido.'}, status=status.HTTP_404_NOT_FOUND)

        centre.veterinarians.remove(vet)
        return Response({'message': f'Il veterinario {vet.first_name} {vet.last_name} è stato rimosso dal centro {centre.name}.'})

    @action(detail=True, methods=['get'], url_path='veterinarians')
    def list_veterinarians(self, request, pk=None):
        """
        Restituisce la lista dei veterinari associati a un centro specifico.
        """
        centre = self.get_object()
        vets = centre.veterinarians.all()
        data = [
            {
                'id': vet.id,
                'first_name': vet.first_name,
                'last_name': vet.last_name,
                'email': vet.email
            } for vet in vets
        ]
        return Response(data)