// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:ecommerce_mobile_app/core/logging/app_logger.dart' as _i701;
import 'package:ecommerce_mobile_app/core/logging/console_app_logger.dart'
    as _i314;
import 'package:ecommerce_mobile_app/cubit/profile/profile_cubit.dart' as _i739;
import 'package:ecommerce_mobile_app/di/third_party_module.dart' as _i498;
import 'package:ecommerce_mobile_app/repositories/auth_repository.dart'
    as _i290;
import 'package:ecommerce_mobile_app/repositories/user_repository.dart'
    as _i463;
import 'package:ecommerce_mobile_app/services/remote/firebase_service.dart'
    as _i527;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyModule.sharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i558.FlutterSecureStorage>(
      () => thirdPartyModule.secureStorage(),
    );
    gh.factory<_i59.FirebaseAuth>(() => thirdPartyModule.firebaseAuth());
    gh.factory<_i974.FirebaseFirestore>(
      () => thirdPartyModule.firebaseFirestore(),
    );
    gh.lazySingleton<_i701.AppLogger>(() => _i314.ConsoleAppLogger());
    gh.lazySingleton<_i527.FirebaseService>(
      () => _i527.FirebaseService(
        gh<_i59.FirebaseAuth>(),
        gh<_i701.AppLogger>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i290.AuthRepository>(
      () => _i290.AuthRepository(
        gh<_i527.FirebaseService>(),
        gh<_i701.AppLogger>(),
      ),
    );
    gh.lazySingleton<_i463.UserRepository>(
      () => _i463.UserRepository(
        gh<_i527.FirebaseService>(),
        gh<_i701.AppLogger>(),
      ),
    );
    gh.lazySingleton<_i739.ProfileCubit>(
      () => _i739.ProfileCubit(
        gh<_i463.UserRepository>(),
        gh<_i527.FirebaseService>(),
        gh<_i701.AppLogger>(),
      ),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i498.ThirdPartyModule {}
