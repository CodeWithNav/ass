// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageModelAdapter extends TypeAdapter<_$_ImageModel> {
  @override
  final int typeId = 5;

  @override
  _$_ImageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_ImageModel(
      author: fields[0] as String,
      url: fields[1] as String,
      id: fields[2] as String,
      isDownloaded: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$_ImageModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.isDownloaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ImageModel _$$_ImageModelFromJson(Map<String, dynamic> json) =>
    _$_ImageModel(
      author: json['author'] as String,
      url: json['download_url'] as String,
      id: json['id'] as String,
      isDownloaded: json['isDownloaded'] as bool,
    );

Map<String, dynamic> _$$_ImageModelToJson(_$_ImageModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      'download_url': instance.url,
      'id': instance.id,
      'isDownloaded': instance.isDownloaded,
    };
