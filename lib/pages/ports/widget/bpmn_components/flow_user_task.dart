import 'dart:convert';
import 'package:diagram_editor/src/canvas_context/model/component_data.dart';
import 'package:diagram_editor_apps/core/diagram_editor_core/extensions/string_null_or_empty_extension.dart';
import 'package:diagram_editor_apps/features/diagram_editor_feature/diagram_editor/presentation/presentation_data_classes/custom_theme_data.dart';
import 'package:diagram_editor_apps/features/diagram_editor_feature/diagram_editor/presentation/presentation_data_classes/frame_data.dart';
import 'package:flutter/material.dart';
import 'package:layout_maker/data/models/layout_maker_params.dart';
import 'package:layout_maker/domain/entities/element_entity.dart';
import 'package:layout_maker/layout_maker.dart';
import '../../../../../data/models/component_data/component_meta_data.dart';
import '../../../../../data/models/product_model.dart';
import '../../../../../domain/repositories/local_frame_data_repository.dart';
import '../../../../../domain/use_cases/frame/get_frame.dart';
import '../../../widgets_with_options/element_with_options_widget.dart';
import 'package:diagram_editor_apps/service/diagram_editor_service/di/di.dart'
    as di;

class FlowUserTask extends StatelessWidget {
  static const String name = 'userTaskFlow';
  final ComponentData _componentData;

  final LocalFrameDataRepository _localFrameDataRepository =
      di.getIt.get<LocalFrameDataRepository>();
  final GetFrame _getFrame = di.getIt.get<GetFrame>();

  FlowUserTask({
    super.key,
    required ComponentData componentData,
  }) : _componentData = componentData;

  @override
  Widget build(BuildContext context) {
    return ElementWithOptionsWidget(
      componentData: _componentData,
      child: FutureBuilder(
          future: _future(_componentData),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.done
                ? LayoutMaker(
                    params: LayoutMakerParams(
                      screen: snapshot.data?.json ?? {},
                      vars: snapshot.data?.varsStorage ?? {},
                      schema: snapshot.data?.schema ?? {},
                      widthFactor: 1,
                      heightFactor: 1,
                      originalSize: true,
                      appColorScheme: _getAppColorScheme(
                          (_componentData.data as ComponentMetaData)
                              .tabData
                              ?.product),
                      appTextTheme: _getAppTextTheme(
                          (_componentData.data as ComponentMetaData)
                              .tabData
                              ?.product),
                      elevation: 4.0,
                      onTapEditorMode: (ElementEntity element) {},
                      isEditorMode: false,
                      onTap:
                          (Map<String, dynamic> vars, String action) async {},
                    ),
                  )
                : const Material(
                    elevation: 4.0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          }),
    );
  }

  Future<FrameData?> _future(ComponentData componentData) async {
    FrameData? result;
    final metaData = (componentData.data as ComponentMetaData);
    Map<String, dynamic> varsStorage =
        await _localFrameDataRepository.getVarsStorage(
      metaData.frameId,
      _componentData,
    );

    Map<String, dynamic> schema = await _localFrameDataRepository.getSchema(
      metaData.frameId,
      _componentData,
    );
    final framesFileId = metaData.tabData?.product?.framesFileId;
    final branch = metaData.tabData?.branch?.name;
    if (metaData.frameId.isNotNullOrEmpty() &&
        framesFileId != null &&
        branch != null) {
      final frameDataOrFailure = await _getFrame.call(
        GetFrameParams(
          frameId: metaData.frameId ?? '',
          fileId: framesFileId,
          branch: branch,
        ),
      );
      frameDataOrFailure.fold((failure) {}, (frame) {
        result = FrameData(
            json: json.decode(frame.json ?? ''),
            frameName: frame.name ?? '',
            varsStorage: varsStorage,
            schema: schema,
            fileId: frame.fileId ?? '',
            frameId: frame.frameId ?? '');
      });
    }
    return result;
  }

  Map<String, dynamic> _getAppColorScheme(ProductModel? product) {
    if (product?.colorScheme != null) {
      final scheme = jsonDecode(product!.colorScheme!);
      return scheme;
    }
    return di.getIt.get<CustomThemeData>().colorScheme;
  }

  Map<String, dynamic> _getAppTextTheme(ProductModel? product) {
    if (product?.typography != null) {
      final typography = jsonDecode(product!.typography!);
      return typography;
    }
    return di.getIt.get<CustomThemeData>().typography;
  }
}
