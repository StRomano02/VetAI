from rest_framework.routers import DefaultRouter
from .views import ShelterViewSet, AnimalViewSet

router = DefaultRouter()
router.register(r'shelters', ShelterViewSet, basename='shelters')
router.register(r'animals', AnimalViewSet, basename='animals')

urlpatterns = router.urls
