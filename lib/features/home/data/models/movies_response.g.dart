// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoviesResponseAdapter extends TypeAdapter<MoviesResponse> {
  @override
  final int typeId = 1;

  @override
  MoviesResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoviesResponse(
      page: fields[0] as int,
      results: (fields[1] as List).cast<MovieModel>(),
      totalPages: fields[2] as int,
      totalResults: fields[3] as int,
      cachedAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MoviesResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.results)
      ..writeByte(2)
      ..write(obj.totalPages)
      ..writeByte(3)
      ..write(obj.totalResults)
      ..writeByte(4)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviesResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
