import { DataTypes } from 'sequelize';

/**
 * Level database model.
 * See https://sequelize.org/v5/manual/models-definition.html to learn how to customize it.
 */
export default function (sequelize) {
  const level = sequelize.define(
    'level',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      levelName: {
        type: DataTypes.TEXT,
        allowNull: false,
        validate: {
          notEmpty: true,
        }
      },
      levelDescription: {
        type: DataTypes.TEXT,
      },
      active: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
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

  level.associate = (models) => {



    
    models.level.belongsTo(models.tenant, {
      as: 'tenant',
    });

    models.level.belongsTo(models.user, {
      as: 'createdBy',
    });

    models.level.belongsTo(models.user, {
      as: 'updatedBy',
    });
  };

  return level;
}
