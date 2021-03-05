import { DataTypes } from 'sequelize';

/**
 * Video database model.
 * See https://sequelize.org/v5/manual/models-definition.html to learn how to customize it.
 */
export default function (sequelize) {
  const video = sequelize.define(
    'video',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      title: {
        type: DataTypes.TEXT,
      },
      embed: {
        type: DataTypes.TEXT,
      },
      link: {
        type: DataTypes.TEXT,
      },
      importHash: {
        type: DataTypes.STRING(255),
        allowNull: true,        
      },
    },
    {
      indexes: [
        {
          unique: true,
          fields: ['importHash', 'tenantId'],
          where: {
            deletedAt: null,
          },
        },

      ],
      timestamps: true,
      paranoid: true,
    },
  );

  video.associate = (models) => {
    models.video.belongsTo(models.lesson, {
      as: 'lesson',
      constraints: false,
    });


    
    models.video.belongsTo(models.tenant, {
      as: 'tenant',
    });

    models.video.belongsTo(models.user, {
      as: 'createdBy',
    });

    models.video.belongsTo(models.user, {
      as: 'updatedBy',
    });
  };

  return video;
}
