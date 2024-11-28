from rest_framework import generics, permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.authtoken.models import Token
from .models import User
from .serializers import UserSerializer

class RegisterUserView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def create(self, request, *args, **kwargs):
                
        request.data['username'] = f"{request.data.get('name', '')}{request.data.get('surname', '')}".strip()        
        print("Dati ricevuti aggiornati:", request.data)
        serializer = self.get_serializer(data=request.data)


        if not serializer.is_valid():
            # Log degli errori di validazione
            print("Errori di validazione:", serializer.errors)
            return Response({
                "success": False,
                "message": "Validation error",
                "errors": serializer.errors  # Dettagli specifici
            }, status=status.HTTP_400_BAD_REQUEST)
        
        self.perform_create(serializer)
        return Response({
            "success": True,
            "message": "User created successfully",
            "data": serializer.data
        }, status=status.HTTP_201_CREATED)
        

class LoginUserView(APIView):
    def post(self, request):
        from django.contrib.auth import authenticate
        username = request.data.get('username')
        password = request.data.get('password')
        user = authenticate(username=username, password=password)
        if user:
            token, _ = Token.objects.get_or_create(user=user)
            return Response({'token': token.key, 'role': user.role})
        return Response({'error': 'Invalid credentials'}, status=400)

class ProfileView(generics.RetrieveUpdateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_object(self):
        return self.request.user